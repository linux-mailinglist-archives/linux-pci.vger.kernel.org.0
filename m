Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525C12BC46A
	for <lists+linux-pci@lfdr.de>; Sun, 22 Nov 2020 08:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgKVHgE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Nov 2020 02:36:04 -0500
Received: from lonlinode-sdnproxy-1.icoremail.net ([139.162.193.133]:56634
        "HELO lonlinode-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1726461AbgKVHgE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Nov 2020 02:36:04 -0500
Received: from localhost (unknown [113.247.217.134])
        by c1app12 (Coremail) with SMTP id DAINCgBH+haiFLpfNmawAA--.39220S3;
        Sun, 22 Nov 2020 15:34:58 +0800 (CST)
From:   Chen Baozi <chenbaozi@phytium.com.cn>
To:     Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH v3 2/2] ACPI: Advertise Interrupt ResourceSource support
Date:   Sun, 22 Nov 2020 15:34:53 +0800
Message-Id: <20201122073453.5758-2-chenbaozi@phytium.com.cn>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201122073453.5758-1-chenbaozi@phytium.com.cn>
References: <20201122073453.5758-1-chenbaozi@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DAINCgBH+haiFLpfNmawAA--.39220S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW8Cw1DZw45Wr1ktw4rGrg_yoW5uF48pa
        n293W5CrWkZa98Aa4kCw4rXFy5Ja1aka42grWDGa43Zay0kF1DJr47tFyUWa4j9F43GFWY
        qrnIqFZ8Kas8uaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7IU890ePUUUUU==
X-Originating-IP: [113.247.217.134]
X-CM-SenderInfo: hfkh0updr2xqxsk13x1xpou0fpof0/1tbiDALkP17uHyEOYAABs0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As mentioned in ACPI v6.3, Table 6-200, the platform will indicate
to the OS whether or not it supports usage of ResourceSource. If
not set, the OS may choose to ignore the ResourceSource parameter
in the extended interrupt descriptor. Since we support parsing
ResoureSource field of interrupts both for platform devices and
PCI Interrupt Link devices now, this patch sets the relevant OSC
bit and checks the capability as described in ACPI specification.

Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/bus.c   | 5 +++++
 drivers/acpi/irq.c   | 3 ++-
 include/linux/acpi.h | 4 +++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 1682f8b454a2..a6af1270bea6 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -281,6 +281,8 @@ bool osc_sb_apei_support_acked;
 bool osc_pc_lpi_support_confirmed;
 EXPORT_SYMBOL_GPL(osc_pc_lpi_support_confirmed);
 
+bool osc_sb_intr_ressrc_support_confirmed;
+
 static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
 static void acpi_bus_osc_support(void)
 {
@@ -303,6 +305,7 @@ static void acpi_bus_osc_support(void)
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
 
+	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_INTR_RESSRC_SUPPORT;
 #ifdef CONFIG_ARM64
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GENERIC_INITIATOR_SUPPORT;
 #endif
@@ -328,6 +331,8 @@ static void acpi_bus_osc_support(void)
 				capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
 			osc_pc_lpi_support_confirmed =
 				capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
+			osc_sb_intr_ressrc_support_confirmed =
+				capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_INTR_RESSRC_SUPPORT;
 		}
 		kfree(context.ret.pointer);
 	}
diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index 2fff5401c3f3..649e09bbd612 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -106,7 +106,8 @@ acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source)
 	acpi_handle handle;
 	acpi_status status;
 
-	if (!source->string_length)
+	if (!osc_sb_intr_ressrc_support_confirmed ||
+	    !source->string_length)
 		return acpi_gsi_domain_id;
 
 	status = acpi_get_handle(NULL, source->string_ptr, &handle);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b182a267fe66..f9ca8e117f31 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -555,10 +555,12 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_SB_PCLPI_SUPPORT			0x00000080
 #define OSC_SB_OSLPI_SUPPORT			0x00000100
 #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
-#define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
+#define OSC_SB_INTR_RESSRC_SUPPORT		0x00002000
+#define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00020000
 
 extern bool osc_sb_apei_support_acked;
 extern bool osc_pc_lpi_support_confirmed;
+extern bool osc_sb_intr_ressrc_support_confirmed;
 
 /* PCI Host Bridge _OSC: Capabilities DWORD 2: Support Field */
 #define OSC_PCI_EXT_CONFIG_SUPPORT		0x00000001
-- 
2.28.0

