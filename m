Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A806567355
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 17:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiGEPvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 11:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiGEPvA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 11:51:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696471F605;
        Tue,  5 Jul 2022 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657036200; x=1688572200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U3saHsgvYciwhLfxacVmiu3qWDreQ9A9gfZULUZztoM=;
  b=BwdCA2jSr9nVyKKJhKuDRlAA+/s+Mxt2UjWkOWCvKrs0cmgmt9QjiOXi
   GherXUgRmApQnimywSMMmOl73HTBuXet9WDDAIGnCXlJdcQbj0gW9n4b7
   +fuceKb2kFj9B97NLAm/maA9gHLrsAYkwnOLz75RThrWNzRkL7KBqY0qS
   s0kFcHP6VNT3+kUlXMTj3KRTIGKtbTBy4IwpCw/l8qCl7wI9DdeqK/cuW
   FJyBEDIsPoDH0eessU1Da+Y9qunfqo75gXcvP0/24JkcEnjBJlTMzUsk9
   T0x9f4yzjVQXvyeHtJ1leXbGW0yKt2S+xATaIxXXQ9zGkkXvpk7CtV4b6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="282143208"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="282143208"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 08:49:59 -0700
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="650213996"
Received: from amangla-mobl.amr.corp.intel.com (HELO localhost) ([10.255.0.184])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 08:49:57 -0700
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
Subject: [PATCH V13 5/9] driver-core: Introduce BIN_ATTR_ADMIN_{RO,RW}
Date:   Tue,  5 Jul 2022 08:49:28 -0700
Message-Id: <20220705154932.2141021-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220705154932.2141021-1-ira.weiny@intel.com>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

