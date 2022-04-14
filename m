Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208A1501AFE
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 20:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbiDNSZe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 14:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344112AbiDNSZ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 14:25:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F27CE8877;
        Thu, 14 Apr 2022 11:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C326061583;
        Thu, 14 Apr 2022 18:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3DBC385A8;
        Thu, 14 Apr 2022 18:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649960581;
        bh=wzKfWIAdPADCpFjCVLCfLjso3Q5ZNWCch4+FqEXQvNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fn9lTUugH69h82pZPlriHFauOMJvUbju/Ke6lCCX8NWk3xUjcq7agauQAKIydtV8O
         pvfS5r6J+K7JamoFRg65p0lpVnJwpMwVAHAJCbbuPHqGHowgJV7HuDkcRndrXoeGUv
         LsWA9wKR1nTwSCOVHl/PqKrS+fTizmeMV8M5pqE1PNMZQq6t/4PhJ5wO9QIplVk8mw
         gjNm1hG9M10jzUIVpOfuHjuJXFoWljKVIREm/6EJoHT55sTaUCR1C8umvDKmUWMJMi
         X6tPdc0eTQl5TNdnrQc2bq9lB/3AUeX7l7o6NxifmwSOt3Sqn0672oHNv8nQ9tjRnt
         c1vOlvXx4UH/g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/3] x86: Log resource clipping for E820 regions
Date:   Thu, 14 Apr 2022 13:22:51 -0500
Message-Id: <20220414182252.758742-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414182252.758742-1-helgaas@kernel.org>
References: <20220414182252.758742-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

When remove_e820_regions() clips a resource because an E820 region overlaps
it, log a note in dmesg to add in debugging.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/kernel/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
index 8ffe68437744..30d524adb012 100644
--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/ioport.h>
+#include <linux/printk.h>
 #include <asm/e820/api.h>
 
 static void resource_clip(struct resource *res, resource_size_t start,
@@ -28,6 +29,7 @@ static void remove_e820_regions(struct resource *avail)
 	int i;
 	struct e820_entry *entry;
 	u64 e820_start, e820_end;
+	struct resource orig = *avail;
 
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		entry = &e820_table->entries[i];
@@ -35,6 +37,11 @@ static void remove_e820_regions(struct resource *avail)
 		e820_end = entry->addr + entry->size - 1;
 
 		resource_clip(avail, e820_start, e820_end);
+		if (orig.start != avail->start || orig.end != avail->end) {
+			pr_info("clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx]\n",
+				 &orig, avail, e820_start, e820_end);
+			orig = *avail;
+		}
 	}
 }
 
-- 
2.25.1

