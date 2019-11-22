Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C446F106F99
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 12:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfKVLQS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 06:16:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34802 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfKVKuz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 05:50:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id j18so9945470wmk.1
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 02:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/inLver145cFol/5bUSjQQctnMruvUV98+tylzxeqnk=;
        b=KvntgGm303h0Ssxf9aIFIK2XkoQiqLGKm8oBQdtFp8m6CkhuS563d23h38idVHFBTS
         kkHWOjKBIeiLqtFnIN5JqRxHj/IPpP1+8FLf2khs7+nbgJ0OpH9sMYPdLblXJN/5mPtZ
         Wb+8873vkfkzhOEno3SZc1Y9APZr1NOsSzkKP1ZCQ6Z0rpQLTlKOI9WgdHg2e1LDo7F0
         tBgAB48y5L6SMpiI5ioJ2KIyTBgMturfH5KATIT+F+PcJxgVRRlhZPFK7De+LuxTeNtE
         M4IA2puSbiUMBj2P+pdk0515MczvrK3k66Sn0WsjBltTEdPU0l74IdtDnv4aQdCAd0EZ
         nmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/inLver145cFol/5bUSjQQctnMruvUV98+tylzxeqnk=;
        b=hfSiIeHfYnRD5OnSneAYqCv0RRT08NJSp6eZxAQWS0HefPjLR4gFh2uyv/DwgioINa
         gjgBZo8xblQgzI89JNNMI1temUrWL+CSxjBa9HTdqDeRy1OKkqWp43XFMaqH/KatQPEs
         cj43tBWlFkcwtSDkzZriqby6GSLamkP2iMxlBGhEIvFhYfAKTMDYrXDcglUGPGGYRCwG
         zBUGa48P5k61z6PG2hEXH9Ojy9P+YeX8EcAdIZkH8ZRJd4lRdxDlzutE5487rac5X1UO
         yuXpa+6P8mLRIll4hgGXZweMKGrTAYVouV11twtAjOGyFy13pAJo6504boOLUG1HKPhM
         owTg==
X-Gm-Message-State: APjAAAX0ZN9pwrC2Ca34n9paApDhFm/IYp/si4AuTiP9RSy8D/if0Dd3
        ugR6LOYKjqE9lizNV0WyhvX9eA==
X-Google-Smtp-Source: APXvYqybl+9ikgvCfSNL7CGfiLoR9Bk+QtDdRzYQU3EDUxB/3MAL7UXcY6vI8QXG4ikVn9LuAUlWLA==
X-Received: by 2002:a05:600c:3cd:: with SMTP id z13mr15785876wmd.105.1574419853787;
        Fri, 22 Nov 2019 02:50:53 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 02:50:53 -0800 (PST)
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
Subject: [RFC 02/13] ACPI: Add VIOT definitions
Date:   Fri, 22 Nov 2019 11:49:49 +0100
Message-Id: <20191122105000.800410-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is temporary, until the VIOT table is published and these
definitions added to ACPICA.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/acpi/actbl2.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index e45ced27f4c3..99c1d747e9d8 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -25,6 +25,7 @@
  * the wrong signature.
  */
 #define ACPI_SIG_IORT           "IORT"	/* IO Remapping Table */
+#define ACPI_SIG_VIOT           "VIOT"	/* Virtual I/O Table */
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
 #define ACPI_SIG_LPIT           "LPIT"	/* Low Power Idle Table */
 #define ACPI_SIG_MADT           "APIC"	/* Multiple APIC Description Table */
@@ -412,6 +413,36 @@ struct acpi_ivrs_memory {
 	u64 memory_length;
 };
 
+/*******************************************************************************
+ *
+ * VIOT - Virtual I/O Table
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_viot {
+	struct acpi_table_header header;
+	u8 reserved[12];
+	struct acpi_table_header base_table;
+};
+
+#define ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU    0x80
+#define ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU   0x81
+
+struct acpi_viot_iort_virtio_pci_iommu {
+	u32 devid;
+};
+
+struct acpi_viot_iort_virtio_mmio_iommu {
+	u64 base_address;
+	u64 span;
+	u64 flags;
+	u64 interrupt;
+};
+
+/* FIXME: rename this monstrosity. */
+#define ACPI_VIOT_IORT_VIRTIO_MMIO_IOMMU_CACHE_COHERENT (1<<0)
+
 /*******************************************************************************
  *
  * LPIT - Low Power Idle Table
-- 
2.24.0

