Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31275501B05
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 20:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344511AbiDNSZg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 14:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344166AbiDNSZ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 14:25:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF509E541F;
        Thu, 14 Apr 2022 11:23:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88D0CB82916;
        Thu, 14 Apr 2022 18:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A3DC385A5;
        Thu, 14 Apr 2022 18:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649960579;
        bh=i6fF8C2eeYGD1JMuZx5bmzgFvF7k9OE5JPcxR8RGGdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XSnVsuM+uLPoTf/buzTKkiGpGVM+oIcmWXrUymeSuMYuBjrW3FXCRWlJIOHDfTn1B
         MyUkkHS79P7vqC3VYB8JQYdnoY0sfSKbLNOoII3jveGgypmXpyX8bnHtfVz9TflHtf
         K4uQoJIwNMg9lY2RHsOKGEumsKxlPTr4YCWCk5G46yGksJsfEd6ry8G11hSpZk8dZj
         dbMklwo+e4izMZakiMEdPvnURGFvBace2YPzYvprUWyFTDGsQ1su2z/82llZWJDk+I
         qnCArmnLq/UUwScSfF0j9Voi3RYcyJIuA4gDSxETwjDGyzgTKwpVQGucSQlueRg4zi
         rNmyHTYYX2nEA==
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
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 1/3] x86/PCI: Eliminate remove_e820_regions() common subexpressions
Date:   Thu, 14 Apr 2022 13:22:50 -0500
Message-Id: <20220414182252.758742-2-helgaas@kernel.org>
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

Add local variables to reduce repetition later.  No functional change
intended.

Link: https://lore.kernel.org/r/20220304035110.988712-2-helgaas@kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/resource.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
index 9b9fb7882c20..8ffe68437744 100644
--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -27,12 +27,14 @@ static void remove_e820_regions(struct resource *avail)
 {
 	int i;
 	struct e820_entry *entry;
+	u64 e820_start, e820_end;
 
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		entry = &e820_table->entries[i];
+		e820_start = entry->addr;
+		e820_end = entry->addr + entry->size - 1;
 
-		resource_clip(avail, entry->addr,
-			      entry->addr + entry->size - 1);
+		resource_clip(avail, e820_start, e820_end);
 	}
 }
 
-- 
2.25.1

