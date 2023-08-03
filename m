Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A7B76F126
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 20:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjHCSB2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 14:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbjHCSA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 14:00:58 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B0A469F
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 11:00:34 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686ba97e4feso1110603b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 11:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085634; x=1691690434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQhuhHdTYaoWEXKHMdQb/AIiT1M0AyktuFOnKoEYTGc=;
        b=InAgb86bmzIXD9aMahgzQO9of8OqAMtZa6GKa8YVTVY7PzoIGrnFhABT5iR9yUDpdb
         eldlLfYqaIJZ0JqKhkz88GT1tI9U1PbaGlbsR4bWfCh1DfbR0ACTXckiDCh17sNzcRLf
         f2WV3qxyJ/rWBuGW2ue4ffM6KV/QUAchCeozTJs9q5S/XcNQOsvfIpSb1jVFwiZ6oFq3
         jlj10cncisuVGqqhaz2WZx3F8TaIGK9I5NjfThtEaXa1XobxVSAqQwN9SPkmA39vlFlT
         61lNiezvzG66VfjvuK2JSEbbCShorb/rqB7QdxU1TuTKXQUwQJNjJ66LD7fLCbx8z4t0
         5PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085634; x=1691690434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQhuhHdTYaoWEXKHMdQb/AIiT1M0AyktuFOnKoEYTGc=;
        b=My8E9CzNi79Z6DWrueZNoJhJrtjw3wI2OOMV1jJF8WSmKCcPirIPPulbepdLjJQzyf
         QndnOZ/aao9nhAE8b62j5QM/RJY296YeAWLfm9QvkhRYMXsxw/cLyWa/D5df/CzcLNIH
         ukT37Q0Mf8Im+hN0qg4vmmUKoZSCcLimnC0EKluoK0yw34ZHCxLth514xZ42V+RG1Vmu
         ogbapGKTRIBWpQzHicci/Be9GgObR4xf6wPK2L11vkIcIRfEb0x/ey49wZ94oj9U21NN
         KOiGXhJMA7+nygOxvd4onUtasuZlMgEv65OoU6fFc+4ZBa4o1RWylnSnTCjWeNCgU0UV
         vrMQ==
X-Gm-Message-State: ABy/qLbq+GeDYHNGXsU4xwVBRjsO4LjF3vJW4FaRxBjIIigBvSfGIVsc
        u2TUFrH485b+vjMLbjovPioeTA==
X-Google-Smtp-Source: APBJJlFH8jQEzxXg6hi15nylBcj+0LbOiklmHj6H9WKQlfFcoVNBUAfYIpWWjK+zKN9M7HAojMJwCw==
X-Received: by 2002:a05:6a21:6d95:b0:134:4f86:7966 with SMTP id wl21-20020a056a216d9500b001344f867966mr25365705pzb.9.1691085634213;
        Thu, 03 Aug 2023 11:00:34 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.11.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:00:33 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v1 08/21] RISC-V: ACPI: RHCT: Add function to get CBO block sizes
Date:   Thu,  3 Aug 2023 23:29:03 +0530
Message-Id: <20230803175916.3174453-9-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CBO related block size in ACPI is provided by RHCT. Add
support to read the CMO node in RHCT to get this information.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h |  9 ++++++
 drivers/acpi/riscv/rhct.c     | 61 +++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index d5604d2073bc..0c4e8b35103e 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -66,6 +66,8 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
 		       unsigned int cpu, const char **isa);
 
 static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
+int acpi_get_cbo_block_size(struct acpi_table_header *table, unsigned int cpu, u32 *cbom_size,
+			    u32 *cboz_size, u32 *cbop_size);
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
@@ -79,6 +81,13 @@ static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
 	return -EINVAL;
 }
 
+static inline int acpi_get_cbo_block_size(struct acpi_table_header *table,
+					  unsigned int cpu, u32 *cbom_size,
+					  u32 *cboz_size, u32 *cbop_size)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
index b280b3e9c7d9..07309525f277 100644
--- a/drivers/acpi/riscv/rhct.c
+++ b/drivers/acpi/riscv/rhct.c
@@ -81,3 +81,64 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
 
 	return -1;
 }
+
+/*
+ * During early boot, the caller should call acpi_get_table() and pass its pointer to
+ * these functions(and free up later). At run time, since this table can be used
+ * multiple times, pass NULL so that the table remains in memory
+ */
+int acpi_get_cbo_block_size(struct acpi_table_header *table, unsigned int cpu,
+			    u32 *cbom_size, u32 *cboz_size, u32 *cbop_size)
+{
+	struct acpi_rhct_node_header *node, *ref_node, *end;
+	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
+	u32 size_hartinfo = sizeof(struct acpi_rhct_hart_info);
+	struct acpi_rhct_hart_info *hart_info;
+	struct acpi_rhct_cmo_node *cmo_node;
+	struct acpi_table_rhct *rhct;
+	u32 *hart_info_node_offset;
+	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+
+	BUG_ON(acpi_disabled);
+
+	if (!table) {
+		rhct = (struct acpi_table_rhct *)acpi_get_rhct();
+		if (!rhct)
+			return -ENOENT;
+	} else {
+		rhct = (struct acpi_table_rhct *)table;
+	}
+
+	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->header.length);
+
+	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
+	     node < end;
+	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {
+		if (node->type == ACPI_RHCT_NODE_TYPE_HART_INFO) {
+			hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node, size_hdr);
+			hart_info_node_offset = ACPI_ADD_PTR(u32, hart_info, size_hartinfo);
+			if (acpi_cpu_id != hart_info->uid)
+				continue;
+
+			for (int i = 0; i < hart_info->num_offsets; i++) {
+				ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
+							rhct, hart_info_node_offset[i]);
+				if (ref_node->type == ACPI_RHCT_NODE_TYPE_CMO) {
+					cmo_node = ACPI_ADD_PTR(struct acpi_rhct_cmo_node,
+								ref_node, size_hdr);
+					if (cbom_size)
+						*cbom_size = 1 << cmo_node->cbom_size;
+
+					if (cboz_size)
+						*cboz_size = 1 << cmo_node->cboz_size;
+
+					if (cbop_size)
+						*cbop_size = 1 << cmo_node->cbop_size;
+					return 0;
+				}
+			}
+		}
+	}
+
+	return -ENOENT;
+}
-- 
2.39.2

