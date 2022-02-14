Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8767D4B546B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 16:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355726AbiBNPSk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 10:18:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355720AbiBNPSi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 10:18:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67B2647567
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 07:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644851909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=imdRsem3qir45ShJ5Znqcxhg95us/ubvR7ZXPO/Mh9w=;
        b=G/lafYGFl5pdDJ5fbJEPny4/XE+gmZz8DL73ULjSC2n21S8I1f0ZA8Gk9FZ6KycfYtsunn
        aQ4rwm5iJWPZjX2kZdgjODJZTwsCObcz/WyVDj1wwZR3oDOrfaoCHmDQcPT4qYdWPDDMdy
        UwCITjrbykQP3Rt+omREKi5pDpvTInw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-s1K7PUI9PIuJH-f9Bm_bUw-1; Mon, 14 Feb 2022 10:18:26 -0500
X-MC-Unique: s1K7PUI9PIuJH-f9Bm_bUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08C50814243;
        Mon, 14 Feb 2022 15:18:24 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CFDE2A19C;
        Mon, 14 Feb 2022 15:18:18 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 1/2] x86/e820: Map EFI_MEMORY_MAPPED_IO to a new E820_TYPE_MMIO type
Date:   Mon, 14 Feb 2022 16:17:58 +0100
Message-Id: <20220214151759.98267-2-hdegoede@redhat.com>
In-Reply-To: <20220214151759.98267-1-hdegoede@redhat.com>
References: <20220214151759.98267-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Map EFI_MEMORY_MAPPED_IO to a new E820_TYPE_MMIO type. The EFI memory-map
has a special type for Memory Mapped IO, add a new E820_TYPE_MMIO type and
when translating the EFI memory-map to an e820_table map
EFI_MEMORY_MAPPED_IO to this new E820_TYPE_MMIO type.

This is a preparation patch for making arch_remove_reservations() treat
EFI_MEMORY_MAPPED_IO ranges differently then other reserved ranged.

All users of E820_TYPE_* have been audited and modified where necessary
so that this patch should not introduce any functional changes.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/include/asm/e820/types.h       |  3 +++
 arch/x86/include/asm/iommu.h            |  3 ++-
 arch/x86/kernel/e820.c                  |  5 +++++
 arch/x86/mm/ioremap.c                   |  1 +
 arch/x86/pci/mmconfig-shared.c          | 15 +++++++++++----
 arch/x86/platform/efi/efi.c             |  5 ++++-
 drivers/firmware/efi/libstub/x86-stub.c |  5 ++++-
 7 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
index 314f75d886d0..d91d4d28fe50 100644
--- a/arch/x86/include/asm/e820/types.h
+++ b/arch/x86/include/asm/e820/types.h
@@ -44,6 +44,9 @@ enum e820_type {
 	 * might alter over the S3 transition:
 	 */
 	E820_TYPE_RESERVED_KERN	= 128,
+
+	/* Used for EFI_MEMORY_MAPPED_IO when translating the EFI memmap */
+	E820_TYPE_MMIO = 129,
 };
 
 /*
diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index bf1ed2ddc74b..ed7329137fef 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -18,7 +18,8 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 	u64 start = rmrr->base_address;
 	u64 end = rmrr->end_address + 1;
 
-	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
+	if (e820__mapped_all(start, end, E820_TYPE_RESERVED) ||
+	    e820__mapped_all(start, end, E820_TYPE_MMIO))
 		return 0;
 
 	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index bc0657f0deed..5fbd2505b10e 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -196,6 +196,7 @@ static void __init e820_print_type(enum e820_type type)
 	case E820_TYPE_UNUSABLE:	pr_cont("unusable");			break;
 	case E820_TYPE_PMEM:		/* Fall through: */
 	case E820_TYPE_PRAM:		pr_cont("persistent (type %u)", type);	break;
+	case E820_TYPE_MMIO:		pr_cont("MMIO");			break;
 	default:			pr_cont("type %u", type);		break;
 	}
 }
@@ -1064,6 +1065,7 @@ static const char *__init e820_type_to_string(struct e820_entry *entry)
 	case E820_TYPE_PMEM:		return "Persistent Memory";
 	case E820_TYPE_RESERVED:	return "Reserved";
 	case E820_TYPE_SOFT_RESERVED:	return "Soft Reserved";
+	case E820_TYPE_MMIO:		return "Memory Mapped IO";
 	default:			return "Unknown E820 type";
 	}
 }
@@ -1080,6 +1082,7 @@ static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
 	case E820_TYPE_PMEM:		/* Fall-through: */
 	case E820_TYPE_RESERVED:	/* Fall-through: */
 	case E820_TYPE_SOFT_RESERVED:	/* Fall-through: */
+	case E820_TYPE_MMIO:		/* Fall-through: */
 	default:			return IORESOURCE_MEM;
 	}
 }
@@ -1091,6 +1094,7 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
 	case E820_TYPE_NVS:		return IORES_DESC_ACPI_NV_STORAGE;
 	case E820_TYPE_PMEM:		return IORES_DESC_PERSISTENT_MEMORY;
 	case E820_TYPE_PRAM:		return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
+	case E820_TYPE_MMIO:		/* Fall-through: */
 	case E820_TYPE_RESERVED:	return IORES_DESC_RESERVED;
 	case E820_TYPE_SOFT_RESERVED:	return IORES_DESC_SOFT_RESERVED;
 	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
@@ -1113,6 +1117,7 @@ static bool __init do_mark_busy(enum e820_type type, struct resource *res)
 	switch (type) {
 	case E820_TYPE_RESERVED:
 	case E820_TYPE_SOFT_RESERVED:
+	case E820_TYPE_MMIO:
 	case E820_TYPE_PRAM:
 	case E820_TYPE_PMEM:
 		return false;
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 026031b3b782..7987e9c899fa 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -552,6 +552,7 @@ static bool memremap_should_map_decrypted(resource_size_t phys_addr,
 	/* Check if the address is outside kernel usable area */
 	switch (e820__get_entry_type(phys_addr, phys_addr + size - 1)) {
 	case E820_TYPE_RESERVED:
+	case E820_TYPE_MMIO:
 	case E820_TYPE_ACPI:
 	case E820_TYPE_NVS:
 	case E820_TYPE_UNUSABLE:
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 758cbfe55daa..3c19353bae10 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -425,7 +425,7 @@ static acpi_status find_mboard_resource(acpi_handle handle, u32 lvl,
 	return AE_OK;
 }
 
-static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
+static bool is_acpi_reserved(u64 start, u64 end)
 {
 	struct resource mcfg_res;
 
@@ -442,7 +442,14 @@ static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
 	return mcfg_res.flags;
 }
 
-typedef bool (*check_reserved_t)(u64 start, u64 end, enum e820_type type);
+static bool is_e820_reserved(u64 start, u64 end)
+{
+	int type = e820__get_entry_type(start, end);
+
+	return type == E820_TYPE_RESERVED || type == E820_TYPE_MMIO;
+}
+
+typedef bool (*check_reserved_t)(u64 start, u64 end);
 
 static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 				     struct pci_mmcfg_region *cfg,
@@ -454,7 +461,7 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 	int num_buses;
 	char *method = with_e820 ? "E820" : "ACPI motherboard resources";
 
-	while (!is_reserved(addr, addr + size, E820_TYPE_RESERVED)) {
+	while (!is_reserved(addr, addr + size)) {
 		size >>= 1;
 		if (size < (16UL<<20))
 			break;
@@ -527,7 +534,7 @@ pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int e
 	/* Don't try to do this check unless configuration
 	   type 1 is available. how about type 2 ?*/
 	if (raw_pci_ops)
-		return is_mmconf_reserved(e820__mapped_all, cfg, dev, 1);
+		return is_mmconf_reserved(is_e820_reserved, cfg, dev, 1);
 
 	return false;
 }
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 147c30a81f15..23b361447417 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -173,10 +173,13 @@ static void __init do_add_efi_memmap(void)
 		case EFI_PERSISTENT_MEMORY:
 			e820_type = E820_TYPE_PMEM;
 			break;
+		case EFI_MEMORY_MAPPED_IO:
+			e820_type = E820_TYPE_MMIO;
+			break;
 		default:
 			/*
 			 * EFI_RESERVED_TYPE EFI_RUNTIME_SERVICES_CODE
-			 * EFI_RUNTIME_SERVICES_DATA EFI_MEMORY_MAPPED_IO
+			 * EFI_RUNTIME_SERVICES_DATA
 			 * EFI_MEMORY_MAPPED_IO_PORT_SPACE EFI_PAL_CODE
 			 */
 			e820_type = E820_TYPE_RESERVED;
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 01ddd4502e28..d0795adc2534 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -470,12 +470,15 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
 		case EFI_RESERVED_TYPE:
 		case EFI_RUNTIME_SERVICES_CODE:
 		case EFI_RUNTIME_SERVICES_DATA:
-		case EFI_MEMORY_MAPPED_IO:
 		case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
 		case EFI_PAL_CODE:
 			e820_type = E820_TYPE_RESERVED;
 			break;
 
+		case EFI_MEMORY_MAPPED_IO:
+			e820_type = E820_TYPE_MMIO;
+			break;
+
 		case EFI_UNUSABLE_MEMORY:
 			e820_type = E820_TYPE_UNUSABLE;
 			break;
-- 
2.33.1

