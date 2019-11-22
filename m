Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3139C106F94
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 12:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfKVKu6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 05:50:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36150 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbfKVKu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 05:50:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so8056028wru.3
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 02:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QSOEuqiwSkp0pKauWHbGWQ/ZTlyMXXOkwS/8GtifrN4=;
        b=W7hCSd2ZSVICv1YxYegFWXSVd6l1oG1ycKu4xwLtfaqmJ1Sr/sS7CGCIhL5OUFctgV
         rFlDn4NTpw09pBYMHxwU6pH2cz9EVPDd82YiD+fipk/QzoM2ZTqkoGqbf2q6XD4JpyS+
         HkMTEjqWyUroxkEhpMb4c/0VyR9Aw+pHVSLPeKpU1gI66GcePWDqG9JF6i6l7iVkhw9O
         HBT/ds4+s3GdaMuNxe380ctWLjNh/MJ2b3Hk57/ghF/Biz69x0PQcTJZJYmGuyc5PIKl
         PPqZBuha1oUQBGfwL1MF98ZPcbDge7wnRdlh9wtxqOZWybLzDV/fSrbPRQTF4GQmLdAt
         HDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QSOEuqiwSkp0pKauWHbGWQ/ZTlyMXXOkwS/8GtifrN4=;
        b=nTOGaxJxyinlqB76YE8wKYUlJmkU9JdCWhhGlHGng5PUVb1LXJwq3K7BU85/qaTdpI
         fQGFnwnGPRviiyZPvF8/3PGGWenbGIX6vz0im0UdURCXUBvE0lpi0wALQDs5C3JXxFDj
         ZN1UV7lro9o+XnLtG/VoTCj0rL+bkwVF5pkCfLWwVWd4i5HXucR/TTXlMVMwM+Quqww7
         WYQehgKA4aQ2vBZRp7Go8wQTtio2wMW1cY4VJIRpyjbpct/2JXqmXIoiqHHaOuA+WwTH
         mDBfavSa3MmSxnRDHwEhGi56fPhNlISAhbNv8NEg2OpRnQB5tVWsL+k+9e6X3rMOs8QS
         CooA==
X-Gm-Message-State: APjAAAVx3BGBNBolhYK8xXcR+HylYmTnv5hzarjEMTv42R39iihIOT2Z
        9a25MNVJI8SCE80WyOjY/I6jMQ==
X-Google-Smtp-Source: APXvYqyrNICCuqc5KqD/VdDvmjiGaMlkwy1z/6XvuGideDQTx1xutKKjYm2Bj/850Fnk8Z8ehJdCwA==
X-Received: by 2002:adf:f088:: with SMTP id n8mr17421703wro.115.1574419855065;
        Fri, 22 Nov 2019 02:50:55 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 02:50:54 -0800 (PST)
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
Subject: [RFC 03/13] ACPI/IORT: Allow registration of external tables
Date:   Fri, 22 Nov 2019 11:49:50 +0100
Message-Id: <20191122105000.800410-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a function to register an IORT table from an external source.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/iort.c       | 22 ++++++++++++++++++++--
 include/linux/acpi_iort.h | 10 ++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index d62a9ea26fae..9c6c91e06f8f 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -144,6 +144,7 @@ typedef acpi_status (*iort_find_node_callback)
 
 /* Root pointer to the mapped IORT table */
 static struct acpi_table_header *iort_table;
+static enum iort_table_source iort_table_source;
 
 static LIST_HEAD(iort_msi_chip_list);
 static DEFINE_SPINLOCK(iort_msi_chip_lock);
@@ -1617,11 +1618,28 @@ static void __init iort_init_platform_devices(void)
 	}
 }
 
+void __init acpi_iort_register_table(struct acpi_table_header *table,
+				     enum iort_table_source source)
+{
+	/*
+	 * Firmware or hypervisor should know better than give us two IORT
+	 * tables.
+	 */
+	if (WARN_ON(iort_table))
+		return;
+
+	iort_table = table;
+	iort_table_source = source;
+
+	iort_init_platform_devices();
+}
+
 void __init acpi_iort_init(void)
 {
 	acpi_status status;
+	static struct acpi_table_header *table;
 
-	status = acpi_get_table(ACPI_SIG_IORT, 0, &iort_table);
+	status = acpi_get_table(ACPI_SIG_IORT, 0, &table);
 	if (ACPI_FAILURE(status)) {
 		if (status != AE_NOT_FOUND) {
 			const char *msg = acpi_format_exception(status);
@@ -1632,5 +1650,5 @@ void __init acpi_iort_init(void)
 		return;
 	}
 
-	iort_init_platform_devices();
+	acpi_iort_register_table(table, IORT_SOURCE_IORT);
 }
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 8e7e2ec37f1b..f4db5fff07cf 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -11,6 +11,11 @@
 #include <linux/fwnode.h>
 #include <linux/irqdomain.h>
 
+enum iort_table_source {
+	IORT_SOURCE_IORT,	/* The Real Thing */
+	IORT_SOURCE_VIOT,	/* Paravirtual extensions */
+};
+
 #define IORT_IRQ_MASK(irq)		(irq & 0xffffffffULL)
 #define IORT_IRQ_TRIGGER_MASK(irq)	((irq >> 32) & 0xffffffffULL)
 
@@ -27,6 +32,8 @@ int iort_register_domain_token(int trans_id, phys_addr_t base,
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_ACPI_IORT
+void acpi_iort_register_table(struct acpi_table_header *table,
+			      enum iort_table_source source);
 void acpi_iort_init(void);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
@@ -37,6 +44,9 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *size);
 const struct iommu_ops *iort_iommu_configure(struct device *dev);
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
 #else
+static void acpi_iort_register_table(struct acpi_table_header *table,
+				     enum iort_table_source source)
+{ }
 static inline void acpi_iort_init(void) { }
 static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 { return req_id; }
-- 
2.24.0

