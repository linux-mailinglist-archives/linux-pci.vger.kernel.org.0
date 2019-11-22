Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57DDA106F96
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 12:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfKVLQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 06:16:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36150 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbfKVKu6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 05:50:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so8056119wru.3
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 02:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MfTtXiG/W/rObmsyirkEQ0i6+kv30tKWKHAFlzXsK50=;
        b=KGaaTyS3Lc/ef+t1SZuZlTE1UsU+JnOw0CHre56ANUeiS1fG2WU5O/YFQcBx5DFQ+g
         C3eEzhT3EtsVVDaPXc0JJnwFtgO1xkFqrrE6GycrJ2S4YEKOcx4s42s4o+D2QSUmsenY
         giJa7ayJtTWwW60SOcSL7s5TyIuTMeag5BlKYTNd2Vpv5b3Ku4VoOfgVTWmpiuNgZfga
         0U9jEO3Ob60MHJopefjx77FsOCYeO+1ZpoKfR2ZI8XHgbGZFlpcgyTQN/mBvo0haJZcQ
         4WN5cxwZz8VzF5n+E1gDTt+EyPoR0GPG3uAOf5O3TZXJzM8psHGvEWv0Dabay2iZKY72
         vmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MfTtXiG/W/rObmsyirkEQ0i6+kv30tKWKHAFlzXsK50=;
        b=mvWbVlmXJGErk38SCd2GRDMoXlRdX7nMTgTjdTgd6AcTOfrUWo+YxQ2vIIwJNzMruS
         a6x9hJ/cSmrcgYeZYCP0Hw+SBVyXkHKBNB9DLbPiSJZ7c1NCBwfr6KkAxR3ztnt9PGeU
         Ozz+ARLunquSYgUElIeOX2RYVkcA8G32T+bMUxUKjPuHtBd6oOc06hLvomMuVai/+mDW
         Omgd+tT9qq15LzVv/uaEN/nffHZ6YCJIWl53BbNjrwLSGS5p9XO4DKyUkxm9mEr2s4hk
         beTd1G37dSYmhbEg/RjXXpoeFxeOwklEq5pU3cvzBZZndPpAY/qo/lopTShFDDk77J1L
         BRKQ==
X-Gm-Message-State: APjAAAVBK1z2+wQQtd3YAnM5VR++s6KfBUn7EwZVRxuAMPKRSOo89Seb
        qDV9WC+Nr5aLybXoRv9TvVl05w==
X-Google-Smtp-Source: APXvYqzYWFFlrhHka1Vw/6sChVYtvTiOJin0SbfQOyNoZG5nnElEymYjGNuUm72JutIfgIh/3EoY2g==
X-Received: by 2002:adf:e885:: with SMTP id d5mr17167901wrm.117.1574419856320;
        Fri, 22 Nov 2019 02:50:56 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 02:50:55 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com,
        mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com
Subject: [RFC 04/13] ACPI/IORT: Add node categories
Date:   Fri, 22 Nov 2019 11:49:51 +0100
Message-Id: <20191122105000.800410-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current node filtering won't work when introducing node types
greater than 63 (such as the virtio-iommu nodes). Add
node_type_matches() to filter nodes by category.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/iort.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 9c6c91e06f8f..1d43fbc0001f 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -18,10 +18,10 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#define IORT_TYPE_MASK(type)	(1 << (type))
-#define IORT_MSI_TYPE		(1 << ACPI_IORT_NODE_ITS_GROUP)
-#define IORT_IOMMU_TYPE		((1 << ACPI_IORT_NODE_SMMU) |	\
-				(1 << ACPI_IORT_NODE_SMMU_V3))
+enum iort_node_category {
+	IORT_MSI_TYPE,
+	IORT_IOMMU_TYPE,
+};
 
 struct iort_its_msi_chip {
 	struct list_head	list;
@@ -38,6 +38,20 @@ struct iort_fwnode {
 static LIST_HEAD(iort_fwnode_list);
 static DEFINE_SPINLOCK(iort_fwnode_lock);
 
+static bool iort_type_matches(u8 type, enum iort_node_category category)
+{
+	switch (category) {
+	case IORT_IOMMU_TYPE:
+		return type == ACPI_IORT_NODE_SMMU ||
+		       type == ACPI_IORT_NODE_SMMU_V3;
+	case IORT_MSI_TYPE:
+		return type == ACPI_IORT_NODE_ITS_GROUP;
+	default:
+		WARN_ON(1);
+		return false;
+	}
+}
+
 /**
  * iort_set_fwnode() - Create iort_fwnode and use it to register
  *		       iommu data in the iort_fwnode_list
@@ -397,7 +411,7 @@ static int iort_get_id_mapping_index(struct acpi_iort_node *node)
 
 static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
 					       u32 id_in, u32 *id_out,
-					       u8 type_mask)
+					       enum iort_node_category category)
 {
 	u32 id = id_in;
 
@@ -406,7 +420,7 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
 		struct acpi_iort_id_mapping *map;
 		int i, index;
 
-		if (IORT_TYPE_MASK(node->type) & type_mask) {
+		if (iort_type_matches(node->type, category)) {
 			if (id_out)
 				*id_out = id;
 			return node;
@@ -458,8 +472,8 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
 }
 
 static struct acpi_iort_node *iort_node_map_platform_id(
-		struct acpi_iort_node *node, u32 *id_out, u8 type_mask,
-		int index)
+		struct acpi_iort_node *node, u32 *id_out,
+		enum iort_node_category category, int index)
 {
 	struct acpi_iort_node *parent;
 	u32 id;
@@ -475,8 +489,8 @@ static struct acpi_iort_node *iort_node_map_platform_id(
 	 * as NC (named component) -> SMMU -> ITS. If the type is matched,
 	 * return the initial dev id and its parent pointer directly.
 	 */
-	if (!(IORT_TYPE_MASK(parent->type) & type_mask))
-		parent = iort_node_map_id(parent, id, id_out, type_mask);
+	if (!iort_type_matches(parent->type, category))
+		parent = iort_node_map_id(parent, id, id_out, category);
 	else
 		if (id_out)
 			*id_out = id;
-- 
2.24.0

