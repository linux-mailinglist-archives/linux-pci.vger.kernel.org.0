Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9042646589B
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 22:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353230AbhLAVzT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 16:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353024AbhLAVyz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 16:54:55 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2393C06174A;
        Wed,  1 Dec 2021 13:51:33 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s13so55400351wrb.3;
        Wed, 01 Dec 2021 13:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2enovZIIcSmPlNGyWYjv9MRu60VM0WFrzLKPmZYvVq8=;
        b=q4eqM+BgJDURYM7X5MaW9dqT0QDyAV/vAoxKXAzAaATfzQz9oET8W9gdp6NASxDf2A
         6USJjwc1aMkRmm9zapaU2JFNtjZJq8iPn0lmq4ogcPEAs1zmSnXhd6SDiIidaylAn16b
         FzZ0MoHN+/+nft0cKV8xQYXNad8luuXWtCbdzQfgAvL1OTp3DXPr1umXU1GYipoagmQu
         tpaIUgGDK7Dr/RiNSOBf1yGuow8Y+KsVLWSahaIQ4qaBb/YbfkhGSxumes5kG3p7gqCM
         jPwzS2YH910JB6ilnTLQKZ/gcTLv7Z6Uc14+N9b1IIyl1/EQZUAkQulKhV7csPsadXZN
         ri/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2enovZIIcSmPlNGyWYjv9MRu60VM0WFrzLKPmZYvVq8=;
        b=bmSl5ArgNWMVS5FWETT96vng0PIMxhRCS08Dx7NHmvJlzHS6QyzCtcEZmqinNVdSJ5
         0rI1yFv53GfnO92JuHwQiIZMA7UaEn47WW/fg1ekkUz8qQXbJJsDUqCJmiNTBPLVdYg/
         5YvP68LbZpkBRyMn6odetc0M6mk+XtqIy2DGoa0e5Zh3f6C4u8fhJBov+Tb239NshoUM
         FhP8Y67Z+DZX/kgVZrS0y6NESQ/MlAgO3rk8UfzMBLDj/THB7bA8I3yl4cI6VMFoqgOu
         p84dGjA2dZgXrwkKfXPK8TzNti4BKFW2j1A5MIDTt0WkEtJ/h32s62wl4yHpzh5NKGA5
         mFAQ==
X-Gm-Message-State: AOAM530sBIgnmgTL55SXg8ir9kBu0Idml9fOsQG35Oen98K5yQZmx5TS
        94yRrQT+n7Q6JKPNZtNylZKkAB1Ncco=
X-Google-Smtp-Source: ABdhPJyAFEjCtAj0/n7TezRMDpEgkhfOKXtlkr27+4yxHkAq/1Ekt04Y14K42Hy3A36RovuMinp/OQ==
X-Received: by 2002:a05:6000:1842:: with SMTP id c2mr9577159wri.301.1638395492251;
        Wed, 01 Dec 2021 13:51:32 -0800 (PST)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id c10sm877879wrb.81.2021.12.01.13.51.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 13:51:31 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, arnd@arndb.de,
        linux@roeck-us.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
Date:   Wed,  1 Dec 2021 22:51:24 +0100
Message-Id: <20211201215127.23550-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
References: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
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
 arch/mips/ralink/mt7621.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index bd71f5b14238..7649416c1cd7 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 #include <linux/memblock.h>
+#include <linux/pci.h>
 
 #include <asm/bootinfo.h>
 #include <asm/mipsregs.h>
@@ -22,6 +23,35 @@
 
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
+		 * FIXME: hardware doesn't accept mask values with 1s after
+		 * 0s (e.g. 0xffef), so it would be great to warn if that's
+		 * about to happen
+		 */
+		mask = ~(entry->res->end - entry->res->start);
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

