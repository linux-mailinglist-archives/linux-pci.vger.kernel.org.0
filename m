Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACD752D75B
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 17:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbiESPWQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 11:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240823AbiESPWO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 11:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D406E62BCB
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 08:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652973727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oM1TAfDo454ZLZga5b5Ef/+sLf4snjsN/4e+Dfq5QSw=;
        b=JITw7mDguXxN/o9tUdUDV/CplSy8FjbEvPjhc1MmR6KpIty6iUveaHrPWZS/gBXjK+Gehm
        guzXPLqnJf2cJnfZEyI2p/0UvuSCOh37DaQ4l3t3nY1pmZqNVJOa2v8h4Ky4hvq/VkTVQ7
        N7e20fFBdxwCXCUomJojHRW1fXurCHQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541--Jr999ykOGKIaJ6pkFEgbQ-1; Thu, 19 May 2022 11:22:04 -0400
X-MC-Unique: -Jr999ykOGKIaJ6pkFEgbQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92D3C18E0BC8;
        Thu, 19 May 2022 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EFC91121314;
        Thu, 19 May 2022 15:22:01 +0000 (UTC)
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
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v9 2/3] x86/PCI: Add DMI quirks to ignore E820 reserved regions on some systems
Date:   Thu, 19 May 2022 17:21:49 +0200
Message-Id: <20220519152150.6135-3-hdegoede@redhat.com>
In-Reply-To: <20220519152150.6135-1-hdegoede@redhat.com>
References: <20220519152150.6135-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some BIOS-es contain bugs where they add addresses which are already
used in some other manner to the PCI host bridge window returned by
the ACPI _CRS method. To avoid this Linux by default excludes
E820 reserved regions when allocating addresses since 2010, see:
commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
space").

Recently (2019) some systems have shown-up with E820 reserved regions
which cover the entire _CRS returned PCI bridge memory window, causing
all attempts to assign memory to PCI BARs which have not been setup by
the BIOS to fail. For example here are the relevant dmesg bits from
a Lenovo IdeaPad 3 15IIL 81WE:

 [mem 0x000000004bc50000-0x00000000cfffffff] reserved
 pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
 pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
 pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]

Outright removing the code to remove E820 reserved regions when
allocating address space is known to cause regressions on various
existing systems.

Instead disable the removal of E820 reserved regions on models where
this is known to cause the above problem using DMI quirks.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214259
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
BugLink: https://bugs.launchpad.net/bugs/1878279
BugLink: https://bugs.launchpad.net/bugs/1880172
BugLink: https://bugs.launchpad.net/bugs/1884232
BugLink: https://bugs.launchpad.net/bugs/1921649
BugLink: https://bugs.launchpad.net/bugs/1931715
BugLink: https://bugs.launchpad.net/bugs/1932069
Cc: Benoit Grégoire <benoitg@coeus.ca>
Cc: Hui Wang <hui.wang@canonical.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v9:
- Split the addition of DMI quirks out into this new patch
- Add a DMI quirk for the TUXEDO Book XUX7 - Gen12
---
 arch/x86/pci/acpi.c | 87 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 7bde3df68e4c..b88bdfba7908 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -43,6 +43,13 @@ static int __init set_ignore_seg(const struct dmi_system_id *id)
 	return 0;
 }
 
+static int __init set_no_e820(const struct dmi_system_id *id)
+{
+	printk(KERN_INFO "PCI: %s detected: ignoring e820 regions\n", id->ident);
+	pci_use_e820 = false;
+	return 0;
+}
+
 static const struct dmi_system_id pci_crs_quirks[] __initconst = {
 	/* http://bugzilla.kernel.org/show_bug.cgi?id=14183 */
 	{
@@ -137,6 +144,86 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP xw9300 Workstation"),
 		},
 	},
+
+	/*
+	 * Most Lenovo models with "IIL" in their DMI_PRODUCT_VERSION have
+	 * an E820 reservation which covers the entire _CRS returned 32 bit
+	 * PCI bridge memory window, causing all attempts to assign memory to
+	 * 32 bit PCI bars which have not been setup by the BIOS to fail.
+	 * Specifically this often causes some of the I2C controllers to not
+	 * work breaking touchpad support and/or this may cause issues when
+	 * hotplugging thunderbolt connected devices.
+	 *
+	 * This DMI match entry covers the following DMI_PRODUCT_VERSION-s with
+	 * an E820 reservation which covers the entire 32 bit bridge window:
+	 * "IdeaPad 3 14IIL05", "IdeaPad 3 15IIL05", "IdeaPad 3 17IIL05",
+	 * "IdeaPad 5 14IIL05", "IdeaPad 5 15IIL05",
+	 * "IdeaPad Slim 7 14IIL05", "IdeaPad Slim 7 15IIL05",
+	 * "Lenovo BS145-15IIL",
+	 * "Lenovo IdeaPad S145-15IIL", "Lenovo IdeaPad S340-14IIL",
+	 * "Lenovo IdeaPad S340-15IIL", "Lenovo IdeaPad C340-15IIL",
+	 * "Lenovo V14-IIL", "Lenovo V15-IIL", "Lenovo V17-IIL",
+	 * "Lenovo Yoga S740-14IIL", "Lenovo Yoga C940-14IIL",
+	 * "Yoga Slim 7 14IIL05", "Yoga Slim 7 15IIL05"
+	 *
+	 * On some of these the bridge's _CRS method *sometimes* (under unknown
+	 * conditions) has a 64 bit [mem 0x4000000000-0x7fffffffff window].
+	 * This avoids some of the issues, but even then there are still issues
+	 * with assigning some 32 bit only BARs such as some Thunderbolt devs,
+	 * the 00:1f.5 BIOS SPI controller and BAR6 of some nvidia gfx.
+	 *
+	 * This entry also covers the following DMI_PRODUCT_VERSION-s which do
+	 * not need pci_use_e820=false. This quirk is a no-op for these models,
+	 * because there is no overlap between E820 regions and _CRS windows:
+	 * "IdeaPad Flex 5 14IIL05", "IdeaPad Flex 5 15IIL05",
+	 * "Lenovo ThinkBook 14-IIL", "Lenovo ThinkBook 15-IIL",
+	 * "Lenovo Yoga S940-14IIL"
+	 *
+	 * This entry fixes issues reported in the following bugs:
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=206459
+	 * https://bugzilla.redhat.com/show_bug.cgi?id=1871793
+	 * https://bugzilla.redhat.com/show_bug.cgi?id=1868899
+	 * https://bugs.launchpad.net/bugs/1878279
+	 * https://bugs.launchpad.net/bugs/1880172
+	 * https://bugs.launchpad.net/bugs/1921649
+	 * https://bugs.launchpad.net/bugs/1931715
+	 * https://bugs.launchpad.net/bugs/1932069
+	 */
+	{
+		.callback = set_no_e820,
+		.ident = "Lenovo *IIL* product version",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "IIL"),
+		},
+	},
+
+	/*
+	 * The Acer Spin 5 (SP513-54N) has the same E820 reservation covering
+	 * the entire _CRS 32 bit window issue as the Lenovo *IIL* models.
+	 * https://bugs.launchpad.net/bugs/1884232
+	 */
+	{
+		.callback = set_no_e820,
+		.ident = "Acer Spin 5 (SP513-54N)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Spin SP513-54N"),
+		},
+	},
+
+	/*
+	 * Clevo X170KM-G barebones have the same E820 reservation covering
+	 * the entire _CRS 32 bit window issue as the Lenovo *IIL* models.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=214259
+	 */
+	{
+		.callback = set_no_e820,
+		.ident = "Clevo X170KM-G Barebone",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
+		},
+	},
 	{}
 };
 
-- 
2.36.0

