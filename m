Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4ED046B977
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 11:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhLGKxF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 05:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbhLGKxB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 05:53:01 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEE1C061574;
        Tue,  7 Dec 2021 02:49:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p18so10343803wmq.5;
        Tue, 07 Dec 2021 02:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9HHpkggX4sweXF0ORzrKAzn3bt5PBvzw8h2UszZWGl4=;
        b=Or58Wr7n84p+HIB8kbXNTRbyxglVkEgA/vpWoW1YRQDr4S/DKUBGbEEG19WvdfnAMT
         QF1OQWcEsLcoLUvWZN0uceMtBH7oru0jx4+noabB7uneiDyOFTTxn9ewXfJe4XwDMGWe
         ueXO+VLoJxTge5jSfqXlbfwP6+KIKJero89rz9VNk/RlTfTMX+2GGLJ3sdmTr4HwD5aI
         c9YBeFbtcIoYNvIUbAh7je7DlYpnVd1MZ3v4AWcuQEHVUgqGLmB2ORaXZA6v1OdQgHTD
         eQTJaj+cjnr+6StsYIgTDYvHOFLYUHOAsjwEJsXl9u+ip1+en9G6xd4DSyFKL6NDKOTc
         UbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9HHpkggX4sweXF0ORzrKAzn3bt5PBvzw8h2UszZWGl4=;
        b=OmttnETKezaywKGT7Yre++lA4qhau+MsjGx+przLuVjD13g9yvvAAeYmXAUO0466SG
         Jtf249o2K0+aFjOvjKNsYB/kdikvrZuvzCgU4CB4fFwrE61mKM/JcpRGTCyEmoBJ9OmM
         fyyRqkqzGUDtnEzI0pIL82hFunSRSB+zpELUsIqszbm81GdMh7bdZL+gKB9gbOZYExvv
         lGql1TaZm0ueoLUyuZIebXA4ToX7MOaTjTtfp8ctcTdPNF2v3RFT2S1/cUnkEWuNC4vy
         rEF5vrj2QnrpzGG1CWyGyynbMVrB+x4789wALs1DgIUth41ynjHJV8x2lXGfthpn14YT
         oyHg==
X-Gm-Message-State: AOAM530Xyt7TKj0bYM/j5LU3yl1r0u+bkC2bTkKoCJXgnkk5SZyp1Mgx
        /T30Wj1oAvCXRHtwBAlWWgobuS4bDrc=
X-Google-Smtp-Source: ABdhPJyeixASncsMltAFlqH22qqWmTSjHp0LOsnKQT52oyviJ/yEcDSnqMohIvyZNrYk1aTXKlAPMA==
X-Received: by 2002:a05:600c:22ce:: with SMTP id 14mr5692028wmg.152.1638874169718;
        Tue, 07 Dec 2021 02:49:29 -0800 (PST)
Received: from localhost.localdomain (27.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.27])
        by smtp.gmail.com with ESMTPSA id z6sm13958561wrm.93.2021.12.07.02.49.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 02:49:29 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
Date:   Tue,  7 Dec 2021 11:49:21 +0100
Message-Id: <20211207104924.21327-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
References: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI core code call 'pcibios_root_bridge_prepare()' function inside function
'pci_register_host_bridge()'. This point is very good way to properly enter
into this MIPS ralink specific code to properly setup I/O coherency units
with PCI memory addresses.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/ralink/mt7621.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index bd71f5b14238..d6efffd4dd20 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -10,6 +10,8 @@
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 #include <linux/memblock.h>
+#include <linux/pci.h>
+#include <linux/bug.h>
 
 #include <asm/bootinfo.h>
 #include <asm/mipsregs.h>
@@ -22,6 +24,35 @@
 
 static void *detect_magic __initdata = detect_memory_region;
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	struct resource_entry *entry;
+	resource_size_t mask;
+
+	entry = resource_list_first_type(&bridge->windows, IORESOURCE_MEM);
+	if (!entry) {
+		pr_err("Cannot get memory resource\n");
+		return -EINVAL;
+	}
+
+	if (mips_cps_numiocu(0)) {
+		/*
+		 * Hardware doesn't accept mask values with 1s after
+		 * 0s (e.g. 0xffef), so warn if that's happen
+		 */
+		mask = ~(entry->res->end - entry->res->start) & CM_GCR_REGn_MASK_ADDRMASK;
+		WARN_ON(mask && BIT(ffz(~mask)) - 1 != ~mask);
+
+		write_gcr_reg1_base(entry->res->start);
+		write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
+		pr_info("PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
+			(unsigned long long)read_gcr_reg1_base(),
+			(unsigned long long)read_gcr_reg1_mask());
+	}
+
+	return 0;
+}
+
 phys_addr_t mips_cpc_default_phys_base(void)
 {
 	panic("Cannot detect cpc address");
-- 
2.33.0

