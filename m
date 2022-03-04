Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8794CCC62
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 04:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbiCDDxA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 22:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbiCDDxA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 22:53:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65F17664F;
        Thu,  3 Mar 2022 19:52:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6149CB82750;
        Fri,  4 Mar 2022 03:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46E4C340E9;
        Fri,  4 Mar 2022 03:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646365931;
        bh=m3cd/87EOR5r5h766Li1ilZjsk6DttaYV2dfSZj3HW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+IeIAZtMDj2h2VkS9kcikAVbywsuF5BVTyyHjxby+l6VfZYaQyAHAG//+hCDPQrW
         sQSsdzIwbQBWA5pdHpDXlUE1HS0Qw20SGIj+W5n8j4P6SZBiuCM1EbdhH2kTGrvhkf
         LXKPzHQTvZnrIImNacKNRtWswo1uNgt2+nt0L6VJ4m4TydiAbNM0zW2ffaRCwwdkJ2
         aiAQLfr4DQZ9xypgaN+zQYuxdpLHyvIJUzJ/HFwFKfeOnJk0R9tstyD3SAujONte3q
         GjzsaF+thPu6Ny8CpZP2YmJ5Pt+FseujbOTk+NZE/GzTNLZsfLOZsCeOsNJN57oeoI
         Ups0q+fIwOmyw==
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
Subject: [PATCH 1/3] x86/PCI: Eliminate remove_e820_regions() common subexpressions
Date:   Thu,  3 Mar 2022 21:51:09 -0600
Message-Id: <20220304035110.988712-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304035110.988712-1-helgaas@kernel.org>
References: <20220304035110.988712-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
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

