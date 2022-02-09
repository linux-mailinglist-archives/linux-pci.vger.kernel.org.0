Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C724AF63F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 17:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbiBIQOA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 11:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiBIQN5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 11:13:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D7ECC061355
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 08:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644423239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pY1hMIvILcvQ4iy4cx4rzx5NtHdAQGETHaPrSiHWNSI=;
        b=KAWEGKJa1PX2+CfetDOHJ0eg12GGWj5DoM/65gF0r8rV4Ro5kuUU1YAVwxSUaAkPXmV3Zx
        2rQuaEyoiaYnSIsjkFwUKVQcggFLD8mV05UUhnGldsb7RRAuhD13G2/gztvXTnlbzAX4km
        nTGQHCWgwQ4X9zpZa59cq6lLfNOtXHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-xBvaTn-WO8CV8zoxMFJB7A-1; Wed, 09 Feb 2022 11:13:56 -0500
X-MC-Unique: xBvaTn-WO8CV8zoxMFJB7A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F10961926DA9;
        Wed,  9 Feb 2022 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5535A7B03A;
        Wed,  9 Feb 2022 16:13:50 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] x86/PCI: revert "Ignore E820 reservations for bridge windows on newer systems"
Date:   Wed,  9 Feb 2022 17:13:42 +0100
Message-Id: <20220209161342.91721-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 7f7b4236f204 ("x86/PCI: Ignore E820 reservations for bridge windows
on newer systems") fixes the touchpad not working on laptops like
the Lenovo IdeaPad 3 15IIL05 and the Lenovo IdeaPad 5 14IIL05, as well as
fixing thunderbolt hotplug issues on the Lenovo Yoga C940.

Unfortunately it turns out that this is causing issues with suspend/resume
on Lenovo ThinkPad X1 Carbon Gen 2 laptops. So, per the no regressions
policy, rever this. Note I'm looking into another fix for the issues this
fixed.

Fixes: 7f7b4236f204 ("x86/PCI: Ignore E820 reservations for bridge windows on newer systems")
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2029207
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/kernel/resource.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
index 9ae64f9af956..9b9fb7882c20 100644
--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/dmi.h>
 #include <linux/ioport.h>
 #include <asm/e820/api.h>
 
@@ -24,31 +23,11 @@ static void resource_clip(struct resource *res, resource_size_t start,
 		res->start = end + 1;
 }
 
-/*
- * Some BIOS-es contain a bug where they add addresses which map to
- * system RAM in the PCI host bridge window returned by the ACPI _CRS
- * method, see commit 4dc2287c1805 ("x86: avoid E820 regions when
- * allocating address space"). To avoid this Linux by default excludes
- * E820 reservations when allocating addresses since 2010.
- * In 2019 some systems have shown-up with E820 reservations which cover
- * the entire _CRS returned PCI host bridge window, causing all attempts
- * to assign memory to PCI BARs to fail if Linux uses E820 reservations.
- *
- * Ideally Linux would fully stop using E820 reservations, but then
- * the old systems this was added for will regress.
- * Instead keep the old behavior for old systems, while ignoring the
- * E820 reservations for any systems from now on.
- */
 static void remove_e820_regions(struct resource *avail)
 {
-	int i, year = dmi_get_bios_year();
+	int i;
 	struct e820_entry *entry;
 
-	if (year >= 2018)
-		return;
-
-	pr_info_once("PCI: Removing E820 reservations from host bridge windows\n");
-
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		entry = &e820_table->entries[i];
 
-- 
2.33.1

